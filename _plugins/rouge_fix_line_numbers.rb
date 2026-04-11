# frozen_string_literal: true

#
# Fix Rouge line-number HTML to be W3C-valid.
#
# Rouge with line_numbers: true generates:
#
#   <pre class="rougecssclass"><code><table class="rouge-table">
#     <tr>
#       <td class="rouge-gutter gl"><pre class="lineno">...</pre></td>
#       <td class="rouge-code"><pre>...code...</pre></td>
#     </tr>
#   </table></code></pre>
#
# The <table> inside <code> is invalid HTML (code only allows phrasing
# content). This hook restructures the output to:
#
#   <table class="rouge-table">
#     <tr>
#       <td class="rouge-gutter gl"><pre class="lineno">...</pre></td>
#       <td class="rouge-code"><pre><code>...code...</code></pre></td>
#     </tr>
#   </table>
#
# CSS and JS selectors (.rouge-table, .rouge-gutter, .rouge-code pre)
# continue to work without changes.
#

Jekyll::Hooks.register(:documents, :post_render) do |doc|
  next unless doc.output_ext == '.html'

  doc.output = doc.output.gsub(
    %r{<pre\s+class="rougecssclass"><code>(<table\s+class="rouge-table">.*?</table>)</code></pre>}m
  ) do |_match|
    table_html = Regexp.last_match(1)

    # Wrap the code content inside rouge-code with <code>
    table_html = table_html.gsub(
      %r{(<td\s+class="rouge-code">)<pre>(.*?)</pre>(</td>)}m,
      '\1<pre><code>\2</code></pre>\3'
    )

    table_html
  end
end

Jekyll::Hooks.register(:pages, :post_render) do |page|
  next unless page.output_ext == '.html'

  page.output = page.output.gsub(
    %r{<pre\s+class="rougecssclass"><code>(<table\s+class="rouge-table">.*?</table>)</code></pre>}m
  ) do |_match|
    table_html = Regexp.last_match(1)

    table_html = table_html.gsub(
      %r{(<td\s+class="rouge-code">)<pre>(.*?)</pre>(</td>)}m,
      '\1<pre><code>\2</code></pre>\3'
    )

    table_html
  end
end
