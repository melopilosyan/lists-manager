# @cjsx React.DOM

@AddMeal = React.createClass
  getInitialState: ->
    value: ''

  onChange: (val) ->
    @setState value: val

  onAddMeal: (e) ->
    e.preventDefault()
    return if @state.value is ''
    $.post MOR.meals(), {meal: {name: @state.value, order_id: @props.orderId}}
    .done (data) =>
      log 'AddMeal#onAddMeal ajax success', data
      data.orders && (@props.updateOrders(data.orders[0]) || @props.updateMeals(data.orders[0].meals))
    .fail (data) =>
      log 'AddMeal#onAddMeal ajax fail', data

    
  render: ->
    btnClass = 'btn btn-primary' + (@state.value == '' && ' disabled' || '')
    <form className='form-inline' onSubmit={ @onAddMeal } >
      <TextControl id='add-meal' onChange={ @onChange } label={ 'Add a meal per order' } srOnly=true />
      <i className='space'></i>
      { linkFor 'Add', btnClass, @onAddMeal }
    </form>

