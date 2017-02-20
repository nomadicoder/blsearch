# frozen_string_literal: true
class CatalogController < ApplicationController

  include Blacklight::Catalog

  configure_blacklight do |config|
    ## Class for sending and receiving requests from a search index
    # config.repository_class = Blacklight::Solr::Repository
    #
    ## Class for converting Blacklight's url parameters to into request parameters for the search index
    # config.search_builder_class = ::SearchBuilder
    #
    ## Model that maps search index responses to the blacklight response model
    # config.response_model = Blacklight::Solr::Response

    ## Default parameters to send to solr for all search-like requests. See also SearchBuilder#processed_parameters
    config.default_solr_params = {
      rows: 10
    }

    # solr path which will be added to solr base url before the other solr params.
    #config.solr_path = 'select'

    # items to show per page, each number in the array represent another option to choose from.
    #config.per_page = [10,20,50,100]

    ## Default parameters to send on single-document requests to Solr. These settings are the Blackligt defaults (see SearchHelper#solr_doc_params) or
    ## parameters included in the Blacklight-jetty document requestHandler.
    #
    #config.default_document_solr_params = {
    #  qt: 'document',
    #  ## These are hard-coded in the blacklight 'document' requestHandler
    #  # fl: '*',
    #  # rows: 1,
    #  # q: '{!term f=id v=$id}'
    #}

    # solr field configuration for search results/index views
    config.index.title_field = 'event_title_display'
    config.index.display_type_field = 'format'

    # solr field configuration for document/show views
    #config.show.title_field = 'title_display'
    #config.show.display_type_field = 'format'

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

    config.add_facet_field 'caming_group_company_facet', label: 'Caming Group Company'
    config.add_facet_field 'event_type_facet', label: 'Event Type'
    config.add_facet_field 'game_system_facet', label: 'Game System'
    config.add_facet_field 'experience_required_facet', label: 'Experience Required'
    config.add_facet_field 'location_facet', label: 'Location'


    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display
    config.add_index_field 'id', label: 'Game ID'
    config.add_index_field 'event_title_display', label: 'Event Title'

    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display
    config.add_show_field 'game_id_display', label: 'Game'
    config.add_show_field 'caming_group_company_display', label: 'Caming Group Company'
    config.add_show_field 'event_title_display', label: 'Event Title'
    config.add_show_field 'description_display', label: 'Description'
    config.add_show_field 'event_type_display', label: 'Event Type'
    config.add_show_field 'game_system_display', label: 'Game System'
    config.add_show_field 'rules_edition_display', label: 'Rules Edition'
    config.add_show_field 'minimum_players_display', label: 'Minimum Players'
    config.add_show_field 'maximum_players_display', label: 'Maximum Players'
    config.add_show_field 'age_required_display', label: 'Age Required'
    config.add_show_field 'experience_required_display', label: 'Experience Required'
    config.add_show_field 'materials_provided_display', label: 'Materials Provided'
    config.add_show_field 'start_date_display', label: 'Start Date'
    config.add_show_field 'duration_display', label: 'Duration'
    config.add_show_field 'end_date_display', label: 'End Date'
    config.add_show_field 'gm_name_s_display', label: 'Gm Name S'
    config.add_show_field 'web_address_for_more_info_display', label: 'Web Address For More Info'
    config.add_show_field 'email_for_more_info_display', label: 'Email For More Info'
    config.add_show_field 'tournament_display', label: 'Tournament'
    config.add_show_field 'round_number_display', label: 'Round Number'
    config.add_show_field 'total_rounds_display', label: 'Total Rounds'
    config.add_show_field 'minimum_play_time_display', label: 'Minimum Play Time'
    config.add_show_field 'can_attendees_register_for_this_event_display', label: 'Can Attendees Register For This Event'
    config.add_show_field 'event_cost_display', label: 'Event Cost'
    config.add_show_field 'location_display', label: 'Location'
    config.add_show_field 'room_name_display', label: 'Room Name'
    config.add_show_field 'table_number_display', label: 'Table Number'
    config.add_show_field 'special_category_display', label: 'Special Category'
    config.add_show_field 'tickets_available_display', label: 'Tickets Available'
    config.add_show_field 'last_modified_display', label: 'Last Modified'

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

    config.add_search_field 'all_fields', label: 'All Fields'


    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields.

    config.add_search_field('event_title') do |field|
      # solr_parameters hash are sent to Solr as ordinary url query params.
      field.solr_parameters = { :'spellcheck.dictionary' => 'event_title' }

      # :solr_local_parameters will be sent using Solr LocalParams
      # syntax, as eg {! qf=$event_title_qf }. This is neccesary to use
      # Solr parameter de-referencing like $event_title_qf.
      # See: http://wiki.apache.org/solr/LocalParams
      field.solr_local_parameters = {
        qf: '$event_title_qf',
        pf: '$event_title_pf'
      }
    end

    config.add_search_field('gm_name_s') do |field|
      field.solr_parameters = { :'spellcheck.dictionary' => 'gm_name_s' }
      field.solr_local_parameters = {
        qf: '$gm_name_s_qf',
        pf: '$gm_name_s_pf'
      }
    end

    # Specifying a :qt only to show it's possible, and so our internal automated
    # tests can test it. In this case it's the same as
    # config[:default_solr_parameters][:qt], so isn't actually neccesary.
    config.add_search_field('subject') do |field|
      field.solr_parameters = { :'spellcheck.dictionary' => 'subject' }
      field.qt = 'search'
      field.solr_local_parameters = {
        qf: '$subject_qf',
        pf: '$subject_pf'
      }
    end

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    config.add_sort_field 'score desc, pub_date_sort desc, event_title_sort asc', label: 'relevance'
    config.add_sort_field 'pub_date_sort desc, event_title_sort asc', label: 'year'
    config.add_sort_field 'author_sort asc, event_title_sort asc', label: 'author'
    config.add_sort_field 'event_title_sort asc, pub_date_sort desc', label: 'event_title'

    # If there are more than this many search results, no spelling ("did you
    # mean") suggestion is offered.
    config.spell_max = 5

    # Configuration for autocomplete suggestor
    config.autocomplete_enabled = true
    config.autocomplete_path = 'suggest'
  end
end
