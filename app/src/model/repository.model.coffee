"use strict"
module.exports = (sequelize, DataTypes) ->
  repositoryModel = sequelize.define("repositoryModel",

    id:
      type: DataTypes.UUID
      primaryKey: true
      defaultValue: DataTypes.UUIDV4

    repository_id:
      type: DataTypes.INTEGER

    repository_name:
      type: DataTypes.STRING

    user_access_token:
      type: DataTypes.STRING

    last_commit_date:
      type: DataTypes.DATE

  ,
    underscored: true
    timestamps: false
    tableName: "repository"
  )
#  repositoryModel.sync(force: true)
  repositoryModel