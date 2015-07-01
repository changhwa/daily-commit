"use strict"
module.exports = (sequelize, DataTypes) ->
  userModel = sequelize.define("userModel",
    user_access_token:
      type: DataTypes.STRING
      primaryKey: true

    user_id:
      type: DataTypes.STRING

    user_name:
      type: DataTypes.STRING
  ,
    underscored: true
    timestamps: false
    tableName: "users"
  )
  userModel.sync(force: true)
  userModel