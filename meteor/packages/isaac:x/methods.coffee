
if Meteor.isServer
    methods = {}
    x.keys(Settings).map (k) -> x.isObject(Settings[k]) and x.keys(Settings[k]).map (l) ->
        Skl = Settings[k][l]
        x.isString(Skl.meteor_method) and methods[Skl.meteor_method] = (o) ->
            HTTP.call Skl.method, Skl.url, x.interpolateOO Skl.options, o
    Meteor.methods methods
else if Meteor.isClient
	Settings?.public and Settings.public.meteor_methods.map (m) ->
		call[m] = (options) -> Meteor.call m, options.options, (e, result) ->
    		Session.set m, result
    		options.db and db[options.db].insert result.data

