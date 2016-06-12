# @cjsx React.DOM

@App = React.createClass
  displayName: 'App'
  getInitialState: ->
    # hau: has authenticated user
    userLoggedIn: @props.hau

  componentDidMount: ->
    console.log('userLoggedIn', @state.userLoggedIn, 'Routes', MOR.root())

  welcomeMsg: ->
    <div className="jumbotron">
  		<h1>Welcome! My friend</h1>
      <p>Authenticate via Facebook to get started.</p>
    </div>

  render: ->
    @welcomeMsg()

