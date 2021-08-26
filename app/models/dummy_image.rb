class DummyImage
  def product_image
    dummy_image = Struct.new('DummyImage') do
      def variant(resize_to_fill: [])
        'https://placehold.jp/70/d6d6d6/7d7d7d/800x450.png?text=No%20Image'
      end
    end
    dummy_image.new
  end
end
