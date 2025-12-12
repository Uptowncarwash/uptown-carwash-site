module.exports = function(eleventyConfig) {
  // Pass through all existing static HTML files (except blog.html which is now dynamic)
  eleventyConfig.addPassthroughCopy("index.html");
  eleventyConfig.addPassthroughCopy("about.html");
  eleventyConfig.addPassthroughCopy("car-wash-services.html");
  eleventyConfig.addPassthroughCopy("detailing-services.html");
  eleventyConfig.addPassthroughCopy("gift-cards.html");
  eleventyConfig.addPassthroughCopy("unlimited-wash.html");
  eleventyConfig.addPassthroughCopy("memberships.html");
  eleventyConfig.addPassthroughCopy("contact.html");
  eleventyConfig.addPassthroughCopy("free-wash.html");
  eleventyConfig.addPassthroughCopy("coatings.html");
  eleventyConfig.addPassthroughCopy("headlights.html");
  eleventyConfig.addPassthroughCopy("my-membership.html");
  eleventyConfig.addPassthroughCopy("privacy.html");
  eleventyConfig.addPassthroughCopy("terms.html");

  // Pass through CSS folder
  eleventyConfig.addPassthroughCopy("css");

  // Pass through admin folder for Decap CMS
  eleventyConfig.addPassthroughCopy("admin");

  // Pass through all images
  eleventyConfig.addPassthroughCopy("*.png");
  eleventyConfig.addPassthroughCopy("*.jpg");
  eleventyConfig.addPassthroughCopy("*.jpeg");
  eleventyConfig.addPassthroughCopy("*.ico");
  eleventyConfig.addPassthroughCopy("*.svg");

  // Create a collection of blog posts sorted by date (newest first)
  eleventyConfig.addCollection("posts", function(collectionApi) {
    return collectionApi.getFilteredByGlob("src/posts/*.md").sort((a, b) => {
      return new Date(b.data.date) - new Date(a.data.date);
    });
  });

  // Date formatting filter (e.g., "December 9, 2024")
  eleventyConfig.addFilter("dateFormat", function(date) {
    const options = { year: 'numeric', month: 'long', day: 'numeric' };
    return new Date(date).toLocaleDateString('en-US', options);
  });

  // ISO date filter for meta tags (e.g., "2024-12-09")
  eleventyConfig.addFilter("isoDate", function(date) {
    return new Date(date).toISOString().split('T')[0];
  });

  // Limit filter for collections
  eleventyConfig.addFilter("limit", function(arr, limit) {
    return arr.slice(0, limit);
  });

  return {
    dir: {
      input: "src",
      output: "_site",
      includes: "_includes",
      layouts: "_layouts"
    },
    templateFormats: ["md", "njk", "html"],
    markdownTemplateEngine: "njk",
    htmlTemplateEngine: "njk"
  };
};
