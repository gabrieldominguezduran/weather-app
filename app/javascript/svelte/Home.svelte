<script>
  import { onMount } from "svelte";

  const endpoint = "/countries";
  let countries = [];
  let states = [];
  let cities = [];
  let selCountry;
  let selState;
  let selCity;
  let weatherCity;
  let weatherCountry;
  let weather;
  onMount(async function () {
    const response = await fetch(endpoint);
    const data = await response.json();
    if (data) {
      countries = data;
    }
  });
  async function postCountry() {
    const data = { selCountry };
    const requestOptions = {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(data),
    };
    try {
      const response = await fetch("/states", requestOptions);
      const res = await response.json();
      states = res;
      console.log("STATES: ", Object.entries(states).length);
    } catch (error) {
      console.log("error", error);
    }
  }

  async function postState() {
    const data = { selState, selCountry };
    const requestOptions = {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(data),
    };
    try {
      const response = await fetch("/cities", requestOptions);
      const res = await response.json();
      if (res) {
        cities = res;
        console.log("CITIES: ", cities);
      }
    } catch (error) {
      console.log("error", error);
    }
  }

  async function postCity() {
    const data = { selCity };
    const requestOptions = {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(data),
    };
    try {
      const response = await fetch("/weather", requestOptions);
      const res = await response.json();
      if (res) {
        weather = res.weather[0].main;
        weatherCity = res.name;
        weatherCountry = res.sys.country;
      }
    } catch (error) {
      console.log("error", error);
    }
  }
</script>

<!--  -->
<main class="container">
  <div class="flex justify-center">
    <div class="mb-3 xl:w-96">
      <label for="country-select">Choose a country:</label>
      <select
        bind:value={selCountry}
        name="countries"
        id="country-select"
        class="form-select appearance-none
        block
        w-full
        px-3
        py-1.5
        text-base
        font-normal
        text-gray-700
        bg-white bg-clip-padding bg-no-repeat
        border border-solid border-gray-300
        rounded
        transition
        ease-in-out
        m-0
        focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none"
        aria-label="Country select"
        on:change={postCountry}
      >
        <option value="">Please choose a country</option>
        {#each Object.entries(countries) as [code, country]}
          <option value={code}>{country}</option>
        {/each}
      </select>

      {#if Object.entries(states).length > 0}
        <label for="state-select">Choose a state:</label>
        <select
          bind:value={selState}
          name="states"
          id="state-select"
          class="form-select appearance-none
        block
        w-full
        px-3
        py-1.5
        text-base
        font-normal
        text-gray-700
        bg-white bg-clip-padding bg-no-repeat
        border border-solid border-gray-300
        rounded
        transition
        ease-in-out
        m-0
        focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none"
          aria-label="Country select"
          on:change={postState}
        >
          <option value="">Please choose a state</option>
          {#each Object.entries(states) as [code, state]}
            <option value={code}>{state}</option>
          {/each}
        </select>
      {/if}

      {#if cities.length > 0}
        <label for="city-select">Choose a city:</label>
        <select
          bind:value={selCity}
          name="cities"
          id="city-select"
          class="form-select appearance-none
        block
        w-full
        px-3
        py-1.5
        text-base
        font-normal
        text-gray-700
        bg-white bg-clip-padding bg-no-repeat
        border border-solid border-gray-300
        rounded
        transition
        ease-in-out
        m-0
        focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none"
          aria-label="Country select"
          on:change={postCity}
        >
          <option value="">Please choose a city</option>
          {#each cities as city}
            <option value={city}>{city}</option>
          {/each}
        </select>
      {/if}
    </div>
  </div>
  {#if weatherCity}
    <h1 class="text-3xl text-red-600">
      {weatherCity} <small>{weatherCountry}</small>
    </h1>
    <p class="text-xl text-orange-500">{weather}</p>
  {/if}
</main>
