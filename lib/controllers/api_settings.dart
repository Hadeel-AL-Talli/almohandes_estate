class ApiSettings{
  static const apiUrl = "http://app1.tp-iraq.com/api/";
  static const register = "http://app1.tp-iraq.com/api/register";
   static const login = "http://app1.tp-iraq.com/api/login";
   static const option = apiUrl + "options";
   static const home = apiUrl +"properties";
  static const search = apiUrl +"search";
  static const propertyAdd = apiUrl +"property/add";
  static const minmax = apiUrl +"minmax";
  static const user = apiUrl + "user";
  static const propertyDetails = apiUrl + "property/{id}";
  static const myposts = apiUrl+ "user/properties";
  static const deletepost = apiUrl + "property/delete/{id}";
  static const forget_pass = apiUrl + "reset";
  static const resetPass = apiUrl + "reset/check";
  static const changepass  = apiUrl + "reset/new";
  static const updateProfile = apiUrl + "profile/update";
  static const addtofav = apiUrl + "property/favorite/add";
  static const removefromfav = apiUrl + "/property/favorite/remove";
  static const getfav = apiUrl + "user/favorites/";
  static const logout = apiUrl +"logout";




}