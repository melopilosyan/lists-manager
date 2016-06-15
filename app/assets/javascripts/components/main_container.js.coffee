# @cjsx React.DOM

@MainContainer = React.createClass
  getInitialState: ->
    orders: []
    loadingData: true

  componentWillMount: ->
    @requestOrders()

  requestOrders: ->
    @setState loadingData: true
    $.getJSON MOR.orders_url(), (data) =>
      log 'MainContainer#requestOrders', data
      @setState orders: data.orders, loadingData: false

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
    <Orders orders={ @state.orders } user={ @props.user } updateOrders={ @updateOrders } refresh={ @requestOrders } />

  render: ->
    <div className='container'>
      { if @state.loadingData then <Loader /> else if @state.orders.length then @showOrders() else @showWelcome() }
    </div>

