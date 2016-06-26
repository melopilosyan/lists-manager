# @cjsx React.DOM

@AlertBox = React.createClass
  ooops: ->
    if @props.ooops
      <strong>Ooops!!!</strong>
      <i className='space'></i>

  render: ->
    <div className={ 'padding10 alert alert-' + @props.type } >
      { @ooops() }
      { @props.msg }
    </div>

@showInfo = (error) ->
  <AlertBox type='info' msg={ error } ooops=true />

@showWarning = (error) ->
  <AlertBox type='warning' msg={ error } ooops=true />

@showError = (error) ->
  <AlertBox type='danger' msg={ error } ooops=true />

