# frozen_string_literal: true

module ProductsFilter
  def price(integer)
    format("$%.2d USD", integer / 100.0)
  end

  def prettyprint(text)
    text.gsub(/\*(.*)\*/, '<b>\1</b>')
  end

  def count(array)
    array.size
  end

  def paragraph(p)
    "<p>#{p}</p>"
  end
end

class Servlet < LiquidServlet
  def index
    { 'date' => Time.now }
  end

  def products
    products_by_client = products_list_by_clients
    client_id = get_url_params['cliente_id'][0].to_s
    
    { 
      'products' => products_list, 
      'more_products' => more_products_list, 
      'description' => description, 
      'section' => 'Snowboards', 
      'cool_products' => true,
      'products_by_client' => products_by_client[client_id]
    }
  end

  private

  def get_url_params
    url = @request.request_uri().to_s
    uri = URI::parse(url)
    id = uri.path.split('/')[4]
    params = CGI::parse(uri.query)
    return params
  end

  def products_list_by_clients
    {
      "araujopa@gmail.com" => {
        'name' => 'Fabrício Araújo',
        'products' => [
          { 
            'name' => 'Arbor', 
            'price' => 39900, 
            'description' => 'the *arbor draft* is a excellent product' 
          },
          { 
            'name' => 'Arbor Element', 
            'price' => 40000, 
            'description' => 'the *arbor element* rocks for freestyling' },
          { 
            'name' => 'Arbor Diamond', 
            'price' => 59900, 
            'description' => 'the *arbor diamond* is a made up product because im obsessed with arbor and have no creativity' 
          }
        ]
      },
      "bruna.moreira@petlove.com.br" => "Harrisburg",
      "edonmenezes@gmail.com " => "Denver"
    }
  end

  def products_list
    [
      { 
        'name' => 'Arbor', 
        'price' => 39900, 
        'description' => 'the *arbor draft* is a excellent product' 
      },
      { 
        'name' => 'Arbor Element', 
        'price' => 40000, 
        'description' => 'the *arbor element* rocks for freestyling' },
      { 
        'name' => 'Arbor Diamond', 
        'price' => 59900, 
        'description' => 'the *arbor diamond* is a made up product because im obsessed with arbor and have no creativity' 
      }
    ]
  end

  def more_products_list
    [{ 'name' => 'Arbor Catalyst', 'price' => 39900, 'description' => 'the *arbor catalyst* is an advanced drop-through for freestyle and flatground performance and versatility' },
     { 'name' => 'Arbor Fish', 'price' => 40000, 'description' => 'the *arbor fish* is a compact pin that features an extended wheelbase and time-honored teardrop shape' }]
  end

  def description
    "List of Products ~ This is a list of products with price and description."
  end
end
