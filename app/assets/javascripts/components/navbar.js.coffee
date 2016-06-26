# @cjsx React.DOM

@Navbar = React.createClass
  loggingOut: ->
    $.ajax
      url: LM.R.logout_url()
      type: 'DELETE'
      success: @props.onLogout

  loggingIn: ->
    window.open('/auth/facebook', '', 'width=500,height=500')
    
  loggedOutMode: ->
    <li>{ linkFor('Login with Facebook', @loggingIn) }</li>
   
  loggedInMode: ->
    [ <li key='nav-li-1'>{ linkFor('Log Out', @loggingOut) }</li>
      <li key='nav-li-2'><img src={@props.user.image_url} className='img-circle' title={@props.user.name} /></li> ]
   
  render: ->
    <nav className="navbar navbar-default">
      <div className="container">
        <div className="navbar-header">{ linkFor(LM.navbarTitle || 'List Manager', 'navbar-brand') }</div>
        <div id="navbar">
          <ul className="nav navbar-nav navbar-right">
            { @props.user.authenticated && @loggedInMode() || @loggedOutMode() }
          </ul>
        </div>
      </div>
    </nav>

