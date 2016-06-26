# @cjsx React.DOM

@Lists = React.createClass
  head: ->
    if @props.type == 'active'
      <thead>
        <tr>
          <th width='40' className='text-center'>#</th>
          <th>Name</th>
          <th>Creator</th>
          <th>Made on</th>
          <th>State</th>
          <th></th>
        </tr>
      </thead>

  render: ->
    <table className='table table-hover'>
      { @head() }
      <tbody>
        { @props.lists.map (list, index) =>
            <List
              index={ index + 1 }
              list={ list }
              authenticated={ @props.authenticated }
              allowEdit={ @props.allowEdit }
              updateLists={ @props.updateLists }
              key={ 'list-' + list.id } /> }
      </tbody>
    </table>

