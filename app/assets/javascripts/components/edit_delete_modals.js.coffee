# @cjsx React.DOM

EditModal = React.createClass
  getInitialState: ->
    close: false
    value: @props.item.name

  onValueChange: (val) ->
    @setState value: val

  onEdit: ->
    data = {}
    id = @props.item.id
    newValue = @state.value
    data[@props.type] = { name: newValue }

    $.ajax
      url: MOR[@props.type](id)
      type: 'PUT'
      data: data
      success: (data) =>
        log 'EditModal#onEdit ajax succeeded', data
        if data.status == 'ok'
          @setState close: true
          @props.onUpdate id, newValue

  render: ->
    title = 'Edit ' + @props.type
    <Modal id='edit-modal' close={ @state.close } title={ title }
           action={ @onEdit } buttonText='Update' disableAction={ @state.value == '' } >
      <TextControl id='text-edit' label={ title } value={ @props.item.name } onChange={ @onValueChange } />
    </Modal>

renderEditModal = (type, item, editUpdate) ->
  ReactDOM.render <EditModal type={ type } item={ item } onUpdate={ editUpdate } />, MO.editModalContainer

editIconFor = (type, item, editUpdate) ->
  editIconLink type + '-' + item.id + '-edit', renderEditModal.bind(null, type, item, editUpdate)


# DeleteModal class
@DeleteModal = React.createClass
  getInitialState: ->
    close: false

  onDelete: ->
    id = @props.item.id
    $.ajax
      url: MOR[@props.type](id)
      type: 'DELETE'
      success: (data) =>
        @setState close: true
        @props.onUpdate(id)

  render: ->
    <Modal id='delete-modal' close={ @state.close }
        title={ 'Delete ' + @props.item.name + ' ' + @props.type } action={ @onDelete } buttonText='Delete' >
      <p>Normally here had to be a question <code>Are you sure?</code> or something like that</p>
      <p>But I'm sure you know what you are doing</p>
    </Modal>

renderDeleteModal = (type, item, deleteUpdate) ->
  ReactDOM.render <DeleteModal type={ type } item={ item } onUpdate={ deleteUpdate } />, MO.editModalContainer

deleteIconFor = (type, item, deleteUpdate) ->
  deleteIconLink type + '-' + item.id + '-delete', renderDeleteModal.bind(null, type, item, deleteUpdate)



# Show Edit and Delete icons
@actionIconsFor = (item, editUpdate, deleteUpdate) ->
  type = item.meals && 'order' || 'meal'
  [ editIconFor type, item, editUpdate
    <i key={ type + '-' + item.id + '-space'} className='space'></i>
    deleteIconFor(type, item, deleteUpdate) ]

