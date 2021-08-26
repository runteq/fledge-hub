class DummyImage
  def product_image
    dummy_image = Struct.new('DummyImage') do
      def variant(resize_to_fill: [])
        'https://dummyimage.com/720x400'
      end
    end
    dummy_image.new
  end
end
