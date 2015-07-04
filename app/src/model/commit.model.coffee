"use strict"
module.exports = (sequelize, DataTypes) ->
  commitModel = sequelize.define("commitModel",

    commit_id:
      type: DataTypes.STRING
      primaryKey: true

    repository_id:
      type: DataTypes.INTEGER

    commit_author:
      type: DataTypes.STRING

    commit_detail_url:
      type: DataTypes.STRING

    commit_view_url:
      type: DataTypes.STRING

    commit_message:
      type: DataTypes.STRING

    commit_date:
      type: DataTypes.DATE

  ,
    underscored: true
    timestamps: false
    tableName: "git_commit"
  )
#  commitModel.sync(force: true)
  commitModel