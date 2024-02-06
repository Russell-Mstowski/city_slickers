import React, { useState } from "react"
import PropTypes from "prop-types"

const Home = (props) => {
  const [loading, setLoading] = useState(true)
  const [search, setSearch] = useState()

  const searchPlaces = () => {
    alert("Searching...")
  }

  return (
    <React.Fragment>
      <h1>City Slicker</h1>
      
      Search a location by name or description <br /><br />

      <input type="text" name="search" value={search} />
      <button onClick={searchPlaces}>submit</button>
    </React.Fragment>
  )
}

// Home.propTypes = {
//   greeting: PropTypes.string
// };

export default Home
