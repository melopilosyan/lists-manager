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
      log 'MakeOrderModal#makeOrder ajax success', data
      if data.orders
        @setState close: true
        @props.updateOrders(data.orders[0], true)
    .fail (data) =>
      log 'MakeOrderModal#makeOrder ajax fail', data

  onMealValueChange: (value) ->
    @setState mealValue: value

  onOrderValueChange: (value) ->
    @setState orderValue: value

  render: ->
    <Modal
        id='make-order-modal' close={ @state.close } disableAction={ @state.orderValue == '' }
        title={ 'Make new order' } buttonText={ 'Order' } action={ @makeOrder } >
      <TextControl id='new-order' value={ @props.orderValue } label='New order' onChange={ @onOrderValueChange } />
      <TextControl id='add-meal' label='Add meal (optional)' onChange={ @onMealValueChange } />
    </Modal>


renderOrdersModal = (updateOrders) ->
  ReactDOM.render <MakeOrderModal updateOrders={ updateOrders } />, MO.modalContainer

# MakeOrderModal helper function
@makeOrderButton = (updateOrders, cls) ->
  linkFor 'Make order', cls || 'btn btn-primary btn-xs', renderOrdersModal.bind(null, updateOrders)

