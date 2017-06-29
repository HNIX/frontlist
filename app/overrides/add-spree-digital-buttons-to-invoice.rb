# order/show


Deface::Override.new(:virtual_path => "spree/shared/_order_details",
                     :name => "add_digital_downloads_to_invoice",
                     :insert_bottom => "td[data-hook='order_item_description']",
                     :text => %q{
<% if order.state == 'complete' and item.variant.digital? %>
  <% item.digital_links.sort { |a, b| a.digital.attachment.path.end_with?('mobi') ? -1 : 1 }.each do |digital_link| %>
  <% format = File.extname(digital_link.digital.attachment.path).downcase %>
    <div style="width:50%; float:left;">
      <%== "<p><b>" + t("digital_instructions#{format}") +"</b></p>" if t("digital_instructions#{format}").present? %>
      <%= link_to t(:digital_download, :type => t("digital_format#{format}"), :type => format), digital_url(:host => Spree::Config.get(:site_url), :secret => digital_link.secret), :class => "btn btn-success #{format}" %>
    </div>
  <% end %>
<% end %>
                      },
                     :disabled => false)
