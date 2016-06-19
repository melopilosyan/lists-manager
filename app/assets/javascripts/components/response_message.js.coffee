# @cjsx React.DOM

@ResponseMessage = React.createClass
  render: ->
    <div className='alert alert-danger' >
      <strong>Ooops!!!</strong>
      <i className='space'></i>
      { @props.msg }
    </div>

@showError = (error) ->
  <ResponseMessage msg={ error } />
