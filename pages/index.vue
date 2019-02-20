<template>
  <section>
    <div v-show="products">
      <h3>Products</h3>
      <ProductList :products="products" />
    </div>
  </section>
</template>

<script>
import sanity from "~/sanity.js"
import AppLogo from "~/components/AppLogo"
import ProductList from "~/components/ProductList"
const query = `
  {
    "products": *[_type == "product"]
  }
`

export default {
  asyncData() {
    return sanity.fetch(query)
  },
  components: {
    AppLogo,
    ProductList
  }
}
</script>

<style scoped>
section {
  background-size: cover;
}

.title,
.subtitle {
  text-align: center;
  padding: 1em;
}

.title {
  font-size: 10vw;
  padding-bottom: 0.5em;
}

.subtitle {
  padding-bottom: 3em;
}
</style>
