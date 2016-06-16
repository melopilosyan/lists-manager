# @cjsx React.DOM

@Link = React.createClass
  statics:
    num: 0

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

  <Link key={ 'link-' + ++Link.num } cls={ cls } text={ text } onClick={ onClick } />


@iconLink = (onClick, cls) ->
  <Link key={ 'link-' + ++Link.num } cls={ cls } onClick={ onClick } />

@editIconLink = (onClick) ->
  iconLink onClick, 'fa fa-pencil-square-o'

@deleteIconLink = (onClick) ->
  iconLink onClick, 'fa fa-times'

