# @cjsx React.DOM

@ShowListModal = React.createClass
  getInitialState: ->
    items: @props.list.items

  row: (dt, dd) ->
    [ <dt>{ dt }:</dt>
      <dd>{ dd }</dd> ]

  itemsTable: () ->
    <table className='table table-striped' >
      <thead>
        <tr>
          <th>Name</th>
          <th>Added by</th>
          <th>Added on</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
          { @state.items.map (item) =>
              <tr key={ 'item-' + item.id } >
                <td>{ item.name }</td>
                <td>{ item.creator.name }</td>
                <td>{ item.addedOn }</td>
                <td>{ @showActionsFor(item) }</td>
              </tr> }
      </tbody>
    </table>

  showActionsFor: (item) ->
    if @props.allowEdit && @props.list.stateOpen() && item.allowActions
      actionIconsFor item, @updateItemDelete, @updateItemEdit

  updateItemDelete: (id) ->
    @updateItems @state.items.filter (m) -> m.id != id

  updateItemEdit: (id, newValue) ->
    @updateItems @state.items.map (m) ->
      if m.id == id
        item = $.extend(true, {}, m)
        item.name = newValue
        item
      else
        m

  addItem: (item) ->
    @updateItems [item].concat @state.items

  updateItems: (items) ->
    @setState items: items
    list = $.extend true, {}, @props.list
    list.items = items
    @props.updateLists list

  onAddItemError: (error) ->
    @setState error: error

  render: ->
    list = @props.list
    addItem = @props.allowEdit && list.stateOpen() &&
                  @state.items.filter((item) -> item.allowActions).length is 0

    <Modal id='show-list' title='List details' >
      { showError(@state.error) if @state.error }
      <dl className='dl-horizontal' >
        {[
          @row('Name', list.name)
          @row('Made by', list.creator.name)
          @row('Made on', list.madeOn)
          <br key='br' />
          @row('State', list.state)
        ]}
      </dl>
      <h2>
        <small>Items</small>
        <div className='pull-right' >
          { addItem && <AddItem listId={ @props.list.id } addItem={ @addItem } onError={ @onAddItemError } /> }
        </div>
      </h2>
      { @itemsTable() }
    </Modal>


# ShowListModal helper function
@showListDetails = (list, allowEdit, updateLists) ->
  ReactDOM.render <ShowListModal list={ list } allowEdit={ allowEdit } updateLists={ updateLists } />, LM.Modal.container

