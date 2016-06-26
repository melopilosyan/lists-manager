# @cjsx React.DOM

@Link = React.createClass
  statics:
    num: 1
    getKey: ->
      'link-' + @num++

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

  <Link key={ Link.getKey() } cls={ cls } text={ text } onClick={ onClick } />


@iconLink = (onClick, cls) ->
  <Link key={ Link.getKey() } cls={ cls } onClick={ onClick } />

@editIconLink = (onClick) ->
  iconLink onClick, 'fa fa-pencil-square-o'

@deleteIconLink = (onClick) ->
  iconLink onClick, 'fa fa-times'

