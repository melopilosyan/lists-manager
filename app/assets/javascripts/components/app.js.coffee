# @cjsx React.DOM

@App = React.createClass
  getInitialState: -> 
    user: {}
    userChecked: false

  componentWillMount: ->
    window.__informLoggingIn__ = @onLoggingIn
    @requestUserInfo()
    window.MO =
      modalContainer: document.getElementById('modal-container'),
      editModalContainer: document.getElementById('edit-modal-container')

  onLoggingIn: ->
    @requestUserInfo()

  requestUserInfo: ->
    $.getJSON MOR.user_info_url(), (user) =>
      log 'App#requestUserInfo', user
      @setState user: user

  onLogout: ->
    @setState user: {}

  render: ->
    <div>
      <Navbar user={ @state.user } onLogout={ @onLogout } />
      <MainContainer user={ @state.user } />
    </div>

