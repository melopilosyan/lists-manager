# @cjsx React.DOM

@ListsContainer = React.createClass
  getDefaultProps: ->
    type: 'active'

  getInitialState: ->
    lists: []
    loading: true

  componentWillMount: ->
    @requestLists()

  componentWillReceiveProps: (props) ->
    if props.reload || !@props.authenticated && props.authenticated
      @requestLists()

  requestLists: ->
    @setState loading: true
    $.getJSON LM.R.lists_url(), {type: @props.type}, (data) =>
      @props.informReload && @props.informReload()
      @setState lists: data.lists, loading: false

  updateLists: (listOrListId, add, checkStatus) ->
    remove = (listId) =>
      @state.lists.filter (list) -> list.id != listId

    if typeof listOrListId == 'object'
      if checkStatus && listOrListId.stateArchived()
        lists = remove(listOrListId.id)
        @props.onHasFinalized(true)
      else
        lists = add && [listOrListId].concat(@state.lists) ||
                  @state.lists.map (list) -> listOrListId.id == list.id && listOrListId || list
    else
      lists = remove(listOrListId)
    @setState lists: lists

  allowChange: ->
    @props.authenticated && @props.type == 'active'

  addNewBtn: (cls) ->
    if @allowChange()
        addListBtn(@updateLists, cls)

  pleaseLoginMsg: ->
    <footer>Please login in order to add lists</footer>

  noListsMsg: ->
    <blockquote>
      <p>There are no lists in this section</p>
      { @pleaseLoginMsg() if @props.type == 'active' && !@props.authenticated }
    </blockquote>

  body: ->
    if @state.loading
      <Loader />
    else if @state.lists.length
      <Lists
        type={ @props.type }
        lists={ @state.lists }
        authenticated={ @props.authenticated }
        allowEdit={ @allowChange() }
        updateLists={ @updateLists } />
    else
      @noListsMsg()

  render: ->
    btnsCls = 'btn btn-primary btn-xs'

    <div className='row'>
      <div className='col-md-12'>
        <div className='card'>
          <div className='card-block'>
            <h2 className="card-title">
              { @props.type == 'active' && 'Active lists' || 'Archived lists' }
              <span className="pull-right">
                {[ @addNewBtn btnsCls
                   <i key='s1' className='space'></i>
                   linkFor 'Reload', btnsCls, @requestLists ]}
              </span>
            </h2>
          </div>
          <div className='card-block'>
            <div className='box'>
              { @body() }
            </div>
          </div>
        </div>
      </div>
    </div>


