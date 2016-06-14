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

  updateOrders: (order, add) ->
    if typeof order == 'object'
      orders = add && [order].concat(@state.orders) ||
                @state.orders.map (ord) -> order.id == ord.id && order || ord
    else
      orders = @state.orders.filter (o) -> o.id != order
    @setState orders: orders

  pleaseSignIn: ->
    <footer>Please login with FaceBook to be able to make orders</footer>

  showWelcome: ->
    <blockquote>
      <p>Currently there are no orders</p>
      { @props.user.authenticated && makeOrderButton(@updateOrders) || @pleaseSignIn() }
    </blockquote>

  showOrders: ->
    <Orders orders={ @state.orders } user={ @props.user } updateOrders={ @updateOrders } />

  render: ->
    <div className='container'>
      { !@state.ordersRequested && <Loader /> || (@state.orders.length && @showOrders() || @showWelcome()) }
    </div>

