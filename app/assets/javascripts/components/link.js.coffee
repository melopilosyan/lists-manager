# @cjsx React.DOM

@Link = React.createClass
  onClick: (e) ->
    e.preventDefault()
    @props.data.onClick(e)

  render: ->
    <a href='#' className={@props.data.className} onClick={@onClick} >
      {@props.data.text}
    </a>


@linkFor = (text, className, onClick) ->
  if typeof className is 'function'
    onClick = className
    className = ''

  <Link data={
      className: className || ''
      text: text
      onClick: onClick || ->
    } />

