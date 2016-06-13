# @cjsx React.DOM

@App = React.createClass
  getInitialState: -> 
    user: {}
    orders: []

  componentWillMount: ->
    window.__informLoggingIn__ = @informLoggingIn
    @requestCurrentUserInfo()
    @requestOrders()

  informLoggingIn: ->
    @requestCurrentUserInfo()

  requestCurrentUserInfo: ->
    log('App#requestCurrentUserInfo')
    $.getJSON MOR.user_info_url(), (data) =>
      log('App#requestCurrentUserInfo ajax done')
      @setState user: data

  requestOrders: ->
    log 'App#requestOrders'
    $.getJSON MOR.orders_url(), (data) => @setState orders: data

  onLogout: ->
    log('App#onLogout')
    @setState user: {}

  onMakeOrder: ->
    ReactDOM.render(<Modal />, document.getElementById('make-order-modal'))

  pleaseSignIn: ->
    <footer>Please login with FaceBook to be able to make orders</footer>

  makeOrderBtn: ->
    linkFor('Make order', 'btn btn-primary', @onMakeOrder)

  welcome: ->
    <blockquote>
      <p>Currently there are no orders</p>
      { @state.user.authenticated && @makeOrderBtn() || @pleaseSignIn() }
    </blockquote>

  render: ->
    log('App#render')
    <div>
      <Navbar user={@state.user} onLogout={@onLogout} />
      <div className='container'>
        { @welcome() }
      </div>
    </div>

