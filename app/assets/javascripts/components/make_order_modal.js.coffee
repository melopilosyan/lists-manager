# @cjsx React.DOM

@MakeOrderModal = React.createClass
  getDefaultProps: ->
    orderValue: ''

  getInitialState: ->
    close: false
    mealValue:  ''
    orderValue: @props.orderValue

  makeOrder: ->
    $.post MOR.orders(), {order: {name: @state.orderValue, meal: @state.mealValue}}
    .done (data) =>
      if data.orders
        @setState close: true
        @props.updateOrders(data.orders[0], true)
    .fail (data) =>
      log 'MakeOrderModal#makeOrder ajax fail', data

  onMealValueChange: (value, enterPressed) ->
    @setState mealValue: value
    enterPressed && @allowSubmit() && @makeOrder()

  onOrderValueChange: (value, enterPressed) ->
    @setState orderValue: value
    enterPressed && @allowSubmit() && @makeOrder()

  allowSubmit: ->
    @state.orderValue != ''

  render: ->
    <Modal
        id='make-order-modal' close={ @state.close } disableAction={ !@allowSubmit() }
        title={ 'Make new order' } buttonText={ 'Order' } action={ @makeOrder } >
      <TextControl id='new-order' value={ @props.orderValue } label='New order' onChange={ @onOrderValueChange } />
      <TextControl id='add-meal' label='Add meal (optional)' onChange={ @onMealValueChange } />
    </Modal>


renderOrdersModal = (updateOrders) ->
  ReactDOM.render <MakeOrderModal updateOrders={ updateOrders } />, MO.modalContainer

# MakeOrderModal helper function
@makeOrderButton = (updateOrders, cls) ->
  linkFor 'Make order', cls, renderOrdersModal.bind(null, updateOrders)

