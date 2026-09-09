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

module RougeFixLineNumbers
  OUTER = %r{<pre\s+class="rougecssclass"><code>(<table\s+class="rouge-table">.*?</table>)</code></pre>}m
  INNER = %r{(<td\s+class="rouge-code">)<pre>(.*?)</pre>(</td>)}m

  def self.fix(html)
    html.gsub(OUTER) do
      table_html = Regexp.last_match(1)
      table_html.gsub(INNER, '\1<pre><code>\2</code></pre>\3')
    end
  end

  def self.hook(item)
    return unless item.output_ext == '.html'

    item.output = fix(item.output)
  end
end

Jekyll::Hooks.register(:documents, :post_render) { |doc| RougeFixLineNumbers.hook(doc) }
Jekyll::Hooks.register(:pages, :post_render) { |page| RougeFixLineNumbers.hook(page) }
