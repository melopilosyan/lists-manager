# @cjsx React.DOM

@AddItem = React.createClass
  getInitialState: ->
    value: ''

  onChange: (val) ->
    @setState value: val

  onAddItem: (e) ->
    e.preventDefault()
    return if @state.value is ''
    $.post LM.R.items(), {item: {name: @state.value, list_id: @props.listId}}
    .done (data) =>
      data.status == 'nok' && @props.onError(data.msg)
      data.item && @props.addItem(data.item)
    .fail (data) =>
      log 'AddItem#onAddItem ajax fail', data

    
  render: ->
    btnClass = 'btn btn-primary' + (@state.value == '' && ' disabled' || '')
    <form className='form-inline' onSubmit={ @onAddItem } >
      <TextControl id='add-item' onChange={ @onChange } label={ 'Add item' } srOnly=true />
      <i className='space'></i>
      { linkFor 'Add', btnClass, @onAddItem }
    </form>

