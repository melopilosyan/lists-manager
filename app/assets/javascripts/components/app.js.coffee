# @cjsx React.DOM

@App = React.createClass
  getInitialState: -> 
    user: {}
    userChecked: false
    reloadArchiveds: false

  componentWillMount: ->
    @requestUserInfo()

    window.__informLoggingIn__ = @onLoggingIn
    window.LM || (window.LM = {})
    window.LM.Modal =
      container: document.getElementById('modal-container'),
      editContainer: document.getElementById('edit-modal-container')

  onLoggingIn: ->
    @requestUserInfo()

  onLogout: ->
    @setState user: {}

  reloadArchiveds: (reload) ->
    @setState reloadArchiveds: reload

  requestUserInfo: ->
    $.getJSON LM.R.user_info_url(), (user) =>
      @setState user: user

  render: ->
    <div>
      <Navbar user={ @state.user } onLogout={ @onLogout } />
      <div className='container'>
        <ListsContainer authenticated={ @state.user.authenticated } onHasFinalized={ @reloadArchiveds }/>
        <ListsContainer
          type='archived'
          reload={ @state.reloadArchiveds }
          informReloaded={ @reloadArchiveds }
          authenticated={ @state.user.authenticated } />
      </div>
    </div>

