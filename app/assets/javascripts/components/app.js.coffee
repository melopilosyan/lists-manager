# @cjsx React.DOM

@App = React.createClass
  displayName: 'App'
  getInitialState: -> 
    user: {}

  componentWillMount: ->
    @getCurrentUserInfo()

  getCurrentUserInfo: ->
    $.ajax
      url: MOR.user_info()
      dataType: 'json'
    .done (data) =>
      console.log('ajax done', +new Date())
      @setState
        user: data

  welcomeMsg: ->
    <div className="jumbotron">
  		<h1>Welcome! My friend</h1>
      <p>Authenticate via Facebook to get started.</p>
    </div>

  greetings: ->
    <div className="jumbotron">
  		<h1>Hello { @state.user.name }</h1>
    </div>

  render: ->
    console.log('render', @state.user, +new Date())
    @state.user.authenticated && @greetings() || @welcomeMsg()

