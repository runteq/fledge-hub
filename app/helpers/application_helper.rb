module ApplicationHelper
  include Pagy::Frontend

  def embedded_svg(filename, options = {})
    file = File.read("public/images/#{filename}")
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    svg['class'] = options[:class] if options[:class].present?
    content_tag(doc.to_html.delete_prefix('<').chop)
  end

  def product_thumbnail_url(product_image = nil)
    return url_for(product_image.product_image.variant(resize_to_fill: [800, 450])) if product_image

    ProductImage::NO_IMAGE_URL
  end
end
