# @cjsx React.DOM

@MakeOrderModal = React.createClass
  getDefaultProps: ->
    update:     false
    orderID:    0
    orderValue: ''

  getInitialState: ->
    close: false
    mealValue:  ''
    orderValue: @props.orderValue

  makeOrder: ->
    $.post MOR.orders(), {order: {name: @state.orderValue, meal: @state.mealValue}}
    .done (data) =>
      log 'MakeOrderModal#makeOrder ajax success', data
      data.orders && @props.onMakeOrder(@props.update, data.orders[0])
      @setState close: true
    .fail (data) =>
      log 'MakeOrderModal#makeOrder ajax fail', data

  onMealValueChange: (value) ->
    @setState mealValue: value

  onOrderValueChange: (value) ->
    @setState orderValue: value

  askForMeal: ->
    <TextControl id='add-meal' label='Add meal (optional)' onChange={ @onMealValueChange } />
    
  render: ->
    title = @props.update && 'Upate order' || 'Make new order'
    buttonText = @props.update && 'Update' || 'Order'

    <Modal id='make-order-modal' close={ @state.close } title={ title } buttonText={ buttonText } action={ @makeOrder } >
      <TextControl id='new-order' value={ @props.orderValue } label='Make order from' onChange={ @onOrderValueChange } />
      { @props.update || @askForMeal() }
    </Modal>


renderOrdersModal = (onMakeOrder, u, id, v) ->
  ReactDOM.render <MakeOrderModal update={ u } orderID={ id } orderValue={ v } onMakeOrder={ onMakeOrder }/>, document.getElementById('make-order-modal-container')

# MakeOrderModal helper function
@makeOrderButton = (onMakeOrder, cls, update, id, currentValue) ->
  linkFor 'Make order', cls || 'btn btn-primary btn-xs', renderOrdersModal.bind(null, onMakeOrder, update, id, currentValue || '')

