# @cjsx React.DOM

@TextControl = React.createClass
  getDefaultProps: ->
    id:       'control-id'
    label:    'Text'
    value:    ''
    srOnly:   false
    onChange: ->

  getInitialState: ->
    value: @props.value

  onChange: (e) ->
    value = e.target.value
    @setState value: value
    @props.onChange(value)

  onKeyPress: (e) ->
    if e.key == 'Enter'
      @props.onChange @state.value, true

  render: ->
    <div className="form-group" >
      <label className={ @props.srOnly && 'sr-only' || '' } for={ @props.id } >{ @props.label }</label>
      <input onChange={ @onChange } onKeyPress={ @onKeyPress } value={ @state.value } type="text" className="form-control" id={ @props.id } placeholder={ @props.label } />
    </div>

