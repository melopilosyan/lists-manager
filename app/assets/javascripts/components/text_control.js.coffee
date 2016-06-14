# @cjsx React.DOM

@TextControl = React.createClass
  getDefaultProps: ->
    id:      'control-id'
    label:   'Text'
    value:   ''
    onChange: ->

  getInitialState: ->
    value: @props.value

  onChange: (e) ->
    value = e.target.value
    @setState value: value
    @props.onChange(value)

  render: ->
    <div className="form-group">
      <label for={ @props.id } >{ @props.label }</label>
      <input onChange={ @onChange } value={ @state.value } type="text" className="form-control" id={ @props.id } placeholder={ @props.label } />
    </div>

