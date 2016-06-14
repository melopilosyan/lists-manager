# @cjsx React.DOM

@MainContainer = React.createClass
  getInitialState: ->
    orders: []
    ordersRequested: false

  componentWillMount: ->
    @requestOrders()

  requestOrders: ->
    $.getJSON MOR.orders_url(), (data) =>
      log 'MainContainer#requestOrders', data
      @setState orders: data.orders, ordersRequested: true

  onMakeOrder: (update, order) ->
    newOrders = update is yes &&
      @state.orders.map( (ord) -> $.extend(true, {}, ord, order) ) ||
      [order].concat(@state.orders)
    @setState orders: newOrders

  pleaseSignIn: ->
    <footer>Please login with FaceBook to be able to make orders</footer>

  showWelcome: ->
    <blockquote>
      <p>Currently there are no orders</p>
      { @props.user.authenticated && makeOrderButton(@onMakeOrder) || @pleaseSignIn() }
    </blockquote>

  showOrders: ->
    <Orders orders={ @state.orders } user={ @props.user } onMakeOrder={ @onMakeOrder } />

  render: ->
    <div className='container'>
      { !@state.ordersRequested && <Loader /> || (@state.orders.length && @showOrders() || @showWelcome()) }
    </div>

