import React, { useState, useEffect } from "react"
import axios from "axios"

import "../../assets/stylesheets/home.css"

const Home = () => {
  const [loading, setLoading] = useState(true)
  const [places, setPlaces] = useState(null)
  const [query, setQuery] = useState("")
  const [page, setPage] = useState(1)

  const getPlaces = () => {
    axios.get("/places?page=1").then((response) => {
      setPlaces(response.data)
      setLoading(false)
    })
  }

  const search = (e) => {
    e.preventDefault()
    setLoading(true)
    
    axios.get(`/places?search=${query}&page=${page}`)
    .then((response) => {
      setPlaces(response.data)
      setLoading(false)
    })
  }

  // Fetch places on load
  useEffect(() => {
    if (!places) getPlaces()
  })

  return (
    <React.Fragment>
      <div style={{ textAlign: 'center', marginBottom: 50 }}>
        <h1>City Slicker</h1>
        
        <p>Search a location by <b>name</b> or <b>description</b></p>

        <form onSubmit={(e) => {search(e)}}>
          <input type="text" name="query" placeholder="Search" style={{ width: 250, height: 28 }} onChange={(e) => {setQuery(e.target.value)}} />
          <input type="submit" className="submitBtn" value="Submit" />
        </form>
      </div>

      { loading ? (
        <div style={{ textAlign: "center" }}>loading</div>
      ) : (
        <div className="table-content fade-in">
          <table>
            <thead>
              <tr>
                <th scope="col">Name</th>
                <th scope="col">Description</th>
                <th scope="col">Rating</th>
              </tr>
            </thead>
            <tbody>
              { places.map(place => 
                <tr key={place.id}>
                  <td width={150}>{place?.name}</td>
                  <td>{place?.description}</td>
                  <td><b>{place?.rating}</b></td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      )}
    </React.Fragment>
  )
}

export default Home
