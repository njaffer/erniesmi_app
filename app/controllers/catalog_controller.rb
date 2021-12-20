# frozen_string_literal: true
class CatalogController < ApplicationController

  include Blacklight::Catalog
  include Blacklight::Marc::Catalog


  configure_blacklight do |config|
    ## Class for sending and receiving requests from a search index
    # config.repository_class = Blacklight::Solr::Repository
    #
    ## Class for converting Blacklight's url parameters to into request parameters for the search index
    # config.search_builder_class = ::SearchBuilder
    #
    ## Model that maps search index responses to the blacklight response model
    # config.response_model = Blacklight::Solr::Response
    #
    ## Should the raw solr document endpoint (e.g. /catalog/:id/raw) be enabled
    # config.raw_endpoint.enabled = false

    ## Default parameters to send to solr for all search-like requests. See also SearchBuilder#processed_parameters
   
    config.default_solr_params = {
      qt: "search",
      rows: 10,
      # qf: "title_tesim description_tesim creator_tesim keyword_tesim"
      qf: "title_tesim all_text_timv"
    }

    # solr path which will be added to solr base url before the other solr params.
    #config.solr_path = 'select'
    #config.document_solr_path = 'get'

    # items to show per page, each number in the array represent another option to choose from.
    #config.per_page = [10,20,50,100]

    # solr field configuration for search results/index views
    config.index.title_field = 'title_ssi'
    #config.index.display_type_field = 'format'
    #config.index.thumbnail_field = 'thumbnail_path_ss'

    config.add_results_document_tool(:bookmark, partial: 'bookmark_control', if: :render_bookmarks_control?)

    config.add_results_collection_tool(:sort_widget)
    config.add_results_collection_tool(:per_page_widget)
    config.add_results_collection_tool(:view_type_group)

    config.add_show_tools_partial(:bookmark, partial: 'bookmark_control', if: :render_bookmarks_control?)
    #config.add_show_tools_partial(:email, callback: :email_action, validator: :validate_email_params)
    #config.add_show_tools_partial(:sms, if: :render_sms_action?, callback: :sms_action, validator: :validate_sms_params)
    #config.add_show_tools_partial(:citation)

    #config.add_nav_action(:bookmark, partial: 'blacklight/nav/bookmark', if: :render_bookmarks_control?)
    #config.add_nav_action(:search_history, partial: 'blacklight/nav/search_history')

    config.add_nav_action(:about, partial: 'about/about')
    config.add_nav_action(:archives, partial: 'archives/archives')
    config.add_nav_action(:contact, partial: 'contact/contact')
    config.add_nav_action(:support, partial: 'support/support')

    # solr field configuration for document/show views
    #config.show.title_field = 'title_tsim'
    #config.show.display_type_field = 'format'
    #config.show.thumbnail_field = 'thumbnail_path_ss'

    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    #
    # Setting a limit will trigger Blacklight's 'more' facet values link.
    # * If left unset, then all facet values returned by solr will be displayed.
    # * If set to an integer, then "f.somefield.facet.limit" will be added to
    # solr request, with actual solr request being +1 your configured limit --
    # you configure the number of items you actually want _displayed_ in a page.
    # * If set to 'true', then no additional parameters will be sent to solr,
    # but any 'sniffed' request limit parameters will be used for paging, with
    # paging at requested limit -1. Can sniff from facet.limit or
    # f.specific_field.facet.limit solr request params. This 'true' config
    # can be used if you set limits in :default_solr_params, or as defaults
    # on the solr side in the request handler itself. Request handler defaults
    # sniffing requires solr requests to be made with "echoParams=all", for
    # app code to actually have it echo'd back to see it.
    #
    # :show may be set to false if you don't want the facet to be drawn in the
    # facet bar
    #
    # set :index_range to true if you want the facet pagination view to have facet prefix-based navigation
    #  (useful when user clicks "more" on a large facet and wants to navigate alphabetically across a large set of results)
    # :index_range can be an array or range of prefixes that will be used to create the navigation (note: It is case sensitive when searching values)

    config.add_facet_field 'county_ssi', label: 'County'
   
    
    config.add_facet_field 'date_received_ssi', label: 'Date', :query => {
       :years_5 => { label: 'within 5 Years', fq: "date_received_ssi_ssim:[#{Time.zone.now.year - 5 } TO *]" },
       :years_10 => { label: 'within 10 Years', fq: "date_received_ssi_ssim:[#{Time.zone.now.year - 10 } TO *]" },
       :years_25 => { label: 'within 25 Years', fq: "date_received_ssi_ssim:[#{Time.zone.now.year - 25 } TO *]" }
    }


    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    #config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display
    #config.show.title_field = 'title_ssi'
    #config.add_index_field 'title_ssi', label: 'Title'
    config.add_index_field 'county_ssi', label: 'County'
    config.add_index_field 'city_ssi', label: 'City'
    config.add_index_field 'date_received_ssi', label: 'Date'
    config.add_index_field 'date_received_ssi_ssim', label: 'Date'
    
    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display
    config.add_show_field 'title_ssi', label: 'Title'
    config.add_show_field 'title_vern_ssim', label: 'Title'
    config.add_show_field 'county_ssi', label: 'County'
    config.add_show_field 'city_ssi', label: 'City'
    config.add_show_field 'date_received_ssi', label: 'Date'
  
    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different.

    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise.

    #config.add_search_field 'all_fields', label: 'All Fields'


    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields.

   config.add_search_field('all_fields', label: 'All Fields') do |field|
      all_names = config.show_fields.values.map(&:field).join(" ")
      field.solr_parameters = {
        qf: "#{all_names} file_format_tesim all_text_timv",
      }
    end
   

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the Solr field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case). Add the sort: option to configure a
    # custom Blacklight url parameter value separate from the Solr sort fields.
    #config.add_sort_field 'relevance', sort: 'score desc, pub_date_si desc, title_si asc', label: 'relevance'
    #config.add_sort_field 'year-desc', sort: 'pub_date_si desc, title_si asc', label: 'year'
    config.add_sort_field 'date', sort: 'date_received_ssi asc, title_ssi asc', label: 'date'
    config.add_sort_field 'title_si asc, pub_date_si desc', label: 'title'

    # If there are more than this many search results, no spelling ("did you
    # mean") suggestion is offered.
    config.spell_max = 5

    # Configuration for autocomplete suggester
    config.autocomplete_enabled = true
    config.autocomplete_path = 'suggest'
    # if the name of the solr.SuggestComponent provided in your solrconfig.xml is not the
    # default 'mySuggester', uncomment and provide it below
    # config.autocomplete_suggester = 'mySuggester'
  end
end
