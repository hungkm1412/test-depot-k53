require 'spec_helper'

describe "cart_items/show" do
  before(:each) do
    @cart_item = assign(:cart_item, stub_model(CartItem,
      :cart_id => 1,
      :quantity => 2,
      :product_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
