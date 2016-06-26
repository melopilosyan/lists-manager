# @cjsx React.DOM

EditModal = React.createClass
  getInitialState: ->
    close: false
    value: @props.item.name

  onValueChange: (val, enterPressed) ->
    @setState value: val
    enterPressed && @allowEdit() && @onEdit()


  allowEdit: ->
    @state.value != ''

  onEdit: ->
    data = {}
    id = @props.item.id
    newValue = @state.value
    data[@props.type] = { name: newValue }

    $.ajax
      url: LM.R[@props.type](id)
      type: 'PUT'
      data: data
      success: (data) =>
        if data.status == 'ok'
          @setState close: true
          @props.onUpdate id, newValue
        else
          @setState error: data.msg

  render: ->
    title = 'Edit ' + @props.type
    <Modal id='edit-modal' close={ @state.close } title={ title }
           action={ @onEdit } buttonText='Update' disableAction={ !@allowEdit() } >
      {  showError(@state.error) if @state.error }
      <TextControl id='text-edit' label={ title } value={ @props.item.name } onChange={ @onValueChange } />
    </Modal>

renderEditModal = (type, item, editUpdate) ->
  ReactDOM.render <EditModal type={ type } item={ item } onUpdate={ editUpdate } />, LM.Modal.editContainer

editIconFor = (type, item, editUpdate) ->
  editIconLink renderEditModal.bind(null, type, item, editUpdate)


# DeleteModal class
@DeleteModal = React.createClass
  getInitialState: ->
    close: false

  onDelete: ->
    id = @props.item.id
    $.ajax
      url: LM.R[@props.type](id)
      type: 'DELETE'
      success: (data) =>
        if data.status == 'ok'
          @setState close: true
          @props.onUpdate(id)
        else
          @setState error: data.msg

  render: ->
    <Modal id='delete-modal' close={ @state.close }
        title={ 'Delete ' + @props.item.name + ' ' + @props.type } action={ @onDelete } buttonText='Delete' >
      { showError(@state.error) if @state.error }
      <p>Normally here had to be a question <code>Are you sure?</code> or something like that</p>
      <p>But I'm sure you know what you are doing</p>
    </Modal>

renderDeleteModal = (type, item, deleteUpdate) ->
  ReactDOM.render <DeleteModal type={ type } item={ item } onUpdate={ deleteUpdate } />, LM.Modal.editContainer

deleteIconFor = (type, item, deleteUpdate) ->
  deleteIconLink renderDeleteModal.bind(null, type, item, deleteUpdate)



# Show Edit and Delete icons
@actionIconsFor = (item, deleteUpdate, editUpdate) ->
  if item.allowActions
    type = item.items && 'list' || 'item'
    <span>
      { editUpdate && editIconFor type, item, editUpdate }
      <i className='space'></i>
      { deleteIconFor(type, item, deleteUpdate) }
    </span>

