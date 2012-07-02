require 'spec_helper'

describe "cart_items/new" do
  before(:each) do
    assign(:cart_item, stub_model(CartItem,
      :cart_id => 1,
      :quantity => 1,
      :product_id => 1
    ).as_new_record)
  end

  it "renders new cart_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cart_items_path, :method => "post" do
      assert_select "input#cart_item_cart_id", :name => "cart_item[cart_id]"
      assert_select "input#cart_item_quantity", :name => "cart_item[quantity]"
      assert_select "input#cart_item_product_id", :name => "cart_item[product_id]"
    end
  end
end
