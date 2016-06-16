# @cjsx React.DOM

@App = React.createClass
  getInitialState: -> 
    user: {}
    userChecked: false
    reloadArchiveds: false

  componentWillMount: ->
    window.__informLoggingIn__ = @onLoggingIn
    @requestUserInfo()

    # Store some global values
    window.MO =
      modalContainer: document.getElementById('modal-container'),
      editModalContainer: document.getElementById('edit-modal-container')
      Statuses: statuses =
        Ordered: 'Ordered'
        Delivered: 'Delivered'
        Finalized: 'Finalized'
        isOrdered: (order) ->
          order.status == @Ordered

  onLoggingIn: ->
    @requestUserInfo()

  onLogout: ->
    @setState user: {}

  reloadArchiveds: (reload) ->
    @setState reloadArchiveds: reload

  requestUserInfo: ->
    $.getJSON MOR.user_info_url(), (user) =>
      @setState user: user

  render: ->
    <div>
      <Navbar user={ @state.user } onLogout={ @onLogout } />
      <div className='container'>
        <OrdersContainer authenticated={ @state.user.authenticated } onHasFinalized={ @reloadArchiveds }/>
        <OrdersContainer
          type='archived'
          reload={ @state.reloadArchiveds }
          informReloaded={ @reloadArchiveds }
          authenticated={ @state.user.authenticated } />
      </div>
    </div>

