# @cjsx React.DOM

@Link = React.createClass
  onClick: (e) ->
    e.preventDefault()
    @props.onClick(e)

  icon: ->
    <i className={ @props.cls }></i>

  render: ->
    <a href='#' className={ @props.icon && '' || @props.cls } onClick={ @onClick } >
      { @props.icon && @icon() || @props.text }
    </a>


@linkFor = (text, cls = '', onClick = ->) ->
  if typeof cls is 'function'
    onClick = cls
    cls = ''

  <Link cls={ cls } text={ text } onClick={ onClick } />


@iconLink = (key, onClick, cls) ->
  <Link key={ key } cls={ cls } onClick={ onClick } />

@editIconLink = (key, onClick) ->
  iconLink key, onClick, 'fa fa-pencil-square-o'

@deleteIconLink = (key, onClick) ->
  iconLink key, onClick, 'fa fa-times'

