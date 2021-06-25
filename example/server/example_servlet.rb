# frozen_string_literal: true

module ProductsFilter
  def price(integer)
    format("R$ %.2f", integer / 100.0)
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
      'products_by_client' => products_by_client[client_id],
      'news' => news
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
        'email' => 'araujopa@gmail.com',
        'unsubscribe' => 'https://clicks.petlove.com.br/f/a/60VPAspP4x7yix0N193hoQ~~/AAQRxQA~/RgRiswU7P4S8AWh0dHBzOi8vZGFzaGJvYXJkLTA2LmJyYXplLmNvbS9lbmNfdXNlci91bnN1YnNjcmliZT9kPXN6UktOeXJweVczNUFsTm5JNGo1TUElM0QlM0QlMjRCMGxiMnFPM3VESHhURzBSV1Fra3JmcEhWdzhyJTJGUEklMkZWQ1pLcVJFNlZXJTJCNHdzUXNlWU13czFmZ1VPdmolMEFLUlVOV2RPUSUyRjRyTWpDbFAzbU5FT2pQaGI2WVRmQWJmbTF3T2dBNjltWFJ2dXJpRTYycjVubk5kZEtkYyUwQVdGTHRQRHU4Rzc2dnRsdUlnaiUyQjVMQll0MiUyRmlPcFdUUWVyenV6OVo3T3dlWlRBayUyQnFIejRsVFJ5JTJGN3BOJTBBSUNxcTdFZmhMUnhPNXlSTlhNNGxMUHMxeEZjNExvd0N2QjByJTJGYU9pY0JvSWFKaXVNcHRTczYzN2M3N1UlMEFhQnBqWThBamVEbHlCckMyQUF6JTJGOEtha0xvYWdzU0hTOVZ2aExmVkdCRVk4UWkwY0pldXRobFBKSFJxcSUwQXlpaHY4RFpyRHlXMU15ZGdpMkh2JjE9MVcDc3BjQgpgyjuA0GA41vzAUhtlZG9uLm1lbmV6ZXNAcGV0bG92ZS5jb20uYnJYBAAAAGM~',
        'products' => [
          { 
            'name' => 'Petisco Pedigree Dentastix Cuidado Oral Para Cães Adultos Raças Pequenas', 
            'price' => 1349, 
            'image' => 'https://www.petlove.com.br/images/products/214107/large/Petisco_Pedigree_Dentastix_para_C%C3%A3es_Adultos_Ra%C3%A7as_Pequenas_-_7_Unidades_3104638-2_1.jpg?1570119294',
            'link' => 'https://www.petlove.com.br/petisco-pedigree-dentastix-para-racas-pequenas-3104638/p?sku=3104638-2'
          },
          { 
            'name' => 'Petisco Pedigree Dentastix Cuidado Oral Para Cães Adultos Raças Grandes', 
            'price' => 2249, 
            'image' => 'https://www.petlove.com.br/images/products/214128/large/Petisco_Pedigree_Dentastix_para_C%C3%A3es_Adultos_Ra%C3%A7as_Grandes_-_7_Unidades_3104639-3_1.jpg?1570121721',
            'link' => 'https://www.petlove.com.br/petisco-pedigree-dentastix-para-racas-grandes-7-sticks/p?sku=3104639-3'
          },
          { 
            'name' => 'Petisco Pedigree Dentastix Cuidado Oral Para Cães Adultos Raças Médias', 
            'price' => 1349, 
            'image' => 'https://www.petlove.com.br/images/products/214121/large/Petisco_Pedigree_Dentastix_para_C%C3%A3es_Adultos_Ra%C3%A7as_M%C3%A9dias_-_7_Unidades_3104639-2_1.jpg?1570120868',
            'link' => 'https://www.petlove.com.br/petisco-pedigree-dentastix-para-racas-medias-3104639/p?sku=3104639-2'
          },
          { 
            'name' => 'Snacks Oral Fresh Nats para Cães de Raças Médias e Grandes', 
            'price' => 1934, 
            'image' => 'https://www.petlove.com.br/images/products/224989/large/Snacks_Oral_Fresh_Nats_para_C%C3%A3es_de_Ra%C3%A7as_M%C3%A9dias_e_Grandes.jpg?1593010651',
            'link' => 'https://www.petlove.com.br/snacks-oral-fresh-nats-para-caes-de-racas-medias-e-grandes/p?sku=2510198c'
          }
        ]
      },
      "edonmenezes@gmail.com" => {
        'name' => 'Edon Menezes',
        'email' => 'araujopa@gmail.com',
        'unsubscribe' => 'https://clicks.petlove.com.br/f/a/60VPAspP4x7yix0N193hoQ~~/AAQRxQA~/RgRiswU7P4S8AWh0dHBzOi8vZGFzaGJvYXJkLTA2LmJyYXplLmNvbS9lbmNfdXNlci91bnN1YnNjcmliZT9kPXN6UktOeXJweVczNUFsTm5JNGo1TUElM0QlM0QlMjRCMGxiMnFPM3VESHhURzBSV1Fra3JmcEhWdzhyJTJGUEklMkZWQ1pLcVJFNlZXJTJCNHdzUXNlWU13czFmZ1VPdmolMEFLUlVOV2RPUSUyRjRyTWpDbFAzbU5FT2pQaGI2WVRmQWJmbTF3T2dBNjltWFJ2dXJpRTYycjVubk5kZEtkYyUwQVdGTHRQRHU4Rzc2dnRsdUlnaiUyQjVMQll0MiUyRmlPcFdUUWVyenV6OVo3T3dlWlRBayUyQnFIejRsVFJ5JTJGN3BOJTBBSUNxcTdFZmhMUnhPNXlSTlhNNGxMUHMxeEZjNExvd0N2QjByJTJGYU9pY0JvSWFKaXVNcHRTczYzN2M3N1UlMEFhQnBqWThBamVEbHlCckMyQUF6JTJGOEtha0xvYWdzU0hTOVZ2aExmVkdCRVk4UWkwY0pldXRobFBKSFJxcSUwQXlpaHY4RFpyRHlXMU15ZGdpMkh2JjE9MVcDc3BjQgpgyjuA0GA41vzAUhtlZG9uLm1lbmV6ZXNAcGV0bG92ZS5jb20uYnJYBAAAAGM~',
        'products' => [
          { 
            'name' => 'Petisco Pedigree Dentastix Cuidado Oral Para Cães Adultos Raças Pequenas', 
            'price' => 1349, 
            'image' => 'https://www.petlove.com.br/images/products/214107/large/Petisco_Pedigree_Dentastix_para_C%C3%A3es_Adultos_Ra%C3%A7as_Pequenas_-_7_Unidades_3104638-2_1.jpg?1570119294',
            'linl' => 'https://www.petlove.com.br/petisco-pedigree-dentastix-para-racas-pequenas-3104638/p?sku=3104638-2'
          },
          { 
            'name' => 'Petisco Pedigree Dentastix Cuidado Oral Para Cães Adultos Raças Grandes', 
            'price' => 2249, 
            'image' => 'https://www.petlove.com.br/images/products/214128/large/Petisco_Pedigree_Dentastix_para_C%C3%A3es_Adultos_Ra%C3%A7as_Grandes_-_7_Unidades_3104639-3_1.jpg?1570121721',
            'link' => 'https://www.petlove.com.br/petisco-pedigree-dentastix-para-racas-grandes-7-sticks/p?sku=3104639-3'
          },
          { 
            'name' => 'Petisco Pedigree Dentastix Cuidado Oral Para Cães Adultos Raças Médias', 
            'price' => 1349, 
            'image' => 'https://www.petlove.com.br/images/products/214121/large/Petisco_Pedigree_Dentastix_para_C%C3%A3es_Adultos_Ra%C3%A7as_M%C3%A9dias_-_7_Unidades_3104639-2_1.jpg?1570120868',
            'link' => 'https://www.petlove.com.br/petisco-pedigree-dentastix-para-racas-medias-3104639/p?sku=3104639-2'
          },
          { 
            'name' => 'Snacks Oral Fresh Nats para Cães de Raças Médias e Grandes', 
            'price' => 1934, 
            'image' => 'https://www.petlove.com.br/images/products/224989/large/Snacks_Oral_Fresh_Nats_para_C%C3%A3es_de_Ra%C3%A7as_M%C3%A9dias_e_Grandes.jpg?1593010651',
            'link' => 'https://www.petlove.com.br/snacks-oral-fresh-nats-para-caes-de-racas-medias-e-grandes/p?sku=2510198c'
          }
        ]
      },
    }
  end

  def news
    [
      { 
        'name' => 'Como saber se o gato está com febre?',
        'image' => 'https://www.petlove.com.br/dicas/wp-content/uploads/2021/06/febre-gato.jpg',
        'link' => 'https://www.petlove.com.br/dicas/gato-com-febre'
      },
      { 
        'name' => 'Como adestrar cachorro filhote da forma correta',
        'image' => 'https://www.petlove.com.br/dicas/wp-content/uploads/2021/06/poodle-filhote-petlove.jpg',
        'link' => 'https://www.petlove.com.br/dicas/como-adestrar-cachorro-filhote'
      }
    ]
  end
end
