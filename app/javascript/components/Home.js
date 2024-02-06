import React, { useState, useEffect } from "react"
import axios from "axios"

import "../../assets/stylesheets/home.css"

const Home = () => {
  const [loading, setLoading] = useState(true)
  const [places, setPlaces] = useState()
  const [query, setQuery] = useState("")
  const [page, setPage] = useState(1)

  const getPlaces = () => {
    setLoading(true)

    axios.get(`/places`).then((response) => {
      setPlaces(response.data)
      setLoading(false)
    })
  }

  const getPlacesByPage = (currentPage) => {
    setLoading(true)

    axios.get(`/places?page=${currentPage}`).then((response) => {
      setPlaces(response.data)
      setLoading(false)
    })
  }

  const searchPlacesByPage = (currentPage) => {
    setLoading(true)
    
    axios.get(`/places?search=${query}&page=${currentPage}`)
    .then((response) => {
      setPlaces(response.data)
      setLoading(false)
    })
  }

  const handleSearch = (e) => {
    e.preventDefault()
    
    searchPlacesByPage(page)
  }

  const nextPage = () => {
    let currentPage = page + 1

    if (query!=="") {
      searchPlacesByPage(currentPage)      
    } else {
      getPlacesByPage(currentPage)
    }

    setPage(currentPage)
  }

  const previousPage = () => {
    let currentPage = page - 1

    if (query!=="") {
      searchPlacesByPage(currentPage)      
    } else {
      getPlacesByPage(currentPage)
    }

    setPage(currentPage)
  }

  // Capitalize first letter of every sentence
  const formatDescription = (description) => {
    return description.toLowerCase().replace(/(?<=(?:^|[.?!])\W*)[a-z]/g, i => i.toUpperCase())
  }

  // Fetch places on load
  useEffect(() => {
    if (!places) getPlaces()
  })

  return (
    <React.Fragment>
      {/* TODO: Break out into component */}
      <div className="header">
        <h1 className="logo" onClick={() => {window.location.reload()}}>City Slicker</h1>
        
        <p>Search a location by <b>name</b> or <b>description</b></p>

        <form onSubmit={(e) => {handleSearch(e)}}>
          <input type="text" className="search-input" name="query" placeholder="Search" value={query} onChange={(e) => {setQuery(e.target.value)}} />
          <input type="submit" className="submit-btn" value="Submit" />
        </form>
      </div>

      { !loading ? (
        <div>
            {/* TODO: Break out into component */}
            <div className="table-content fade-in">
              <table>
                <thead>
                  <tr>
                    <th scope="col">Name</th>
                    <th scope="col" align="left">Description</th>
                    <th scope="col">Rating</th>
                  </tr>
                </thead>
                { places.length > 0 ? (
                  <tbody>
                    { places.map(place => 
                      <tr key={place.id}>
                        <td width={150}>{place?.name.toLowerCase()}</td>
                        <td>{formatDescription(place?.description)}</td>
                        <td><b>{place?.average_rating}</b></td>
                      </tr>
                    )}
                  </tbody>
                ) : (
                  <tr style={{ textAlign: "center", height: 40}}>
                    <td colspan="100%">
                      No places.
                    </td>
                  </tr>
                )}
              </table>
            </div>
          
            <div className="pagination-btns">
              { page > 1 ? (
                <button className="previous" onClick={() => {previousPage()}}>Previous</button>
              ) : ("")}


              { places.length !== 0 ? (
                <div>
                  {page}

                  <button className="next" onClick={() => {nextPage()}}>Next</button>
                </div>
              ): ("")}
            </div>
        </div>
      ) : ("")}
    </React.Fragment>
  )
}

export default Home
