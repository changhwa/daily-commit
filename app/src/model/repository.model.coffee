"use strict"
module.exports = (sequelize, DataTypes) ->
  repositoryModel = sequelize.define("repositoryModel",

    id:
      type: DataTypes.UUID
      primaryKey: true
      defaultValue: DataTypes.UUIDV4

    repository_id:
      type: DataTypes.STRING

    repository_name:
      type: DataTypes.STRING

    user_access_token:
      type: DataTypes.STRING

  ,
    underscored: true
    timestamps: false
    tableName: "repository"
  )
  repositoryModel.sync(force: true)
  repositoryModel