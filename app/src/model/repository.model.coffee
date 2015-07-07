"use strict"
module.exports = (sequelize, DataTypes) ->
  repositoryModel = sequelize.define("repositoryModel",

    id:
      type: DataTypes.UUID
      primaryKey: true
      defaultValue: DataTypes.UUIDV4

    repository_id:
      type: DataTypes.INTEGER
      unique: 'compositeIndex'

    repository_name:
      type: DataTypes.STRING

    repository_full_name:
      type: DataTypes.STRING

    user_access_token:
      type: DataTypes.STRING
      unique: 'compositeIndex'

    last_commit_date:
      type: DataTypes.DATE

  ,
    underscored: true
    timestamps: false
    tableName: "repository"
    classMethods:
      associate: (models) ->
        models.repositoryModel.hasMany models.commitModel, foreignKey: 'repository_id'
  )
#  repositoryModel.sync(force: true)
  repositoryModel