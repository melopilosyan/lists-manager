# @cjsx React.DOM

@AddListModal = React.createClass
  getDefaultProps: ->
    listValue: ''

  getInitialState: ->
    close: false
    itemValue:  ''
    listValue: @props.listValue

  addList: ->
    $.post LM.R.lists(), {list: {name: @state.listValue, item: @state.itemValue}}
    .done (data) =>
      if data.lists
        @setState close: true
        @props.updateLists(data.lists[0], true)
    .fail (data) =>
      log 'MakeListModal#addList ajax fail', data

  onItemValueChange: (value, enterPressed) ->
    @setState itemValue: value
    enterPressed && @allowSubmit() && @addList()

  onListValueChange: (value, enterPressed) ->
    @setState listValue: value
    enterPressed && @allowSubmit() && @addList()

  allowSubmit: ->
    @state.listValue != ''

  render: ->
    <Modal
        id='make-list-modal' close={ @state.close } disableAction={ !@allowSubmit() }
        title={ 'Add new list' } buttonText={ 'Add' } action={ @addList } >
      <TextControl id='new-list' value={ @props.listValue } label='New list' onChange={ @onListValueChange } />
      <TextControl id='add-item' label='Add item (optional)' onChange={ @onItemValueChange } />
    </Modal>


renderListsModal = (updateLists) ->
  ReactDOM.render <AddListModal updateLists={ updateLists } />, LM.Modal.container

# MakeListModal helper function
@addListBtn = (updateLists, cls) ->
  linkFor 'Add list', cls, renderListsModal.bind(null, updateLists)

