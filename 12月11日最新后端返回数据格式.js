var temp ={
  "accessInterfaces": [
    {
      "path": "/menu/:id",
      "method": "get"
    },
    {
      "path": "/menu",
      "method": "get"
    },
    {
      "path": "/menu/save",
      "method": "post"
    },
    {
      "path": "/interface/paged",
      "method": "get"
    }
  ],
  "accessMenus": [
    
    {
        "title": "大数据分析",
        "path": "/big",
        "icon": "linode",
        "children": [
                {
                  "title": "人口数据分析",
                  "path" : "/people-analyse",
                  "icon": "tint",         
                },
                {
                  "title": "企业数据分析",
                  "path" : "/enterprise-analyse",
                  "icon": "tint",         
                },               
                {
                  "title": "水电气数据分析",
                  "path" : "/wea-analyse",
                  "icon": "tint",         
                },
                {
                  "title": "快递数据分析",
                  "path" : "/express-analyse",
                  "icon": "tint",         
                },
                {
                  "title": "社保数据分析",
                  "path" : "/ss-analyse",
                  "icon": "tint",         
                },
                {
                  "title": "周数据分析",
                  "path" : "/week-analyse",
                  "icon": "tint",         
                },
        ]
    },
    {
		
        "title": "三维立体警务巡防中心",
        "path": "/center",
        "icon": "futbol-o",
        "children": [
            {
              "title": "监控中心",
              "icon": "universal-access", 
                "children": [
                    {
                      "title": "实时监控",
                      "icon": "television",
						"children": [
							{ 
							  "title": '实时监控显示',
							  "path": '/liveview',  
							  "icon": 'play' 
							},
							{ 
							  "title": '地图布控显示',
							  "path": '/real-video',  
							  "icon": 'support' 
							},
						]	
                    },
					{
					 "title": '监控管理',
					 "icon": 'yelp',
					    "children": [
					     { 
						   "title": '历史监控查询', 
						   "path": '/stream-list', 
						   "icon": 'magic' 
					      }
						]
					}
				],
			},
			{
			  "title": "人车情报研判中心",
			  "icon": 'camera', 
			  "path": '/testws'
			},                    
			{
			  "title": "轨迹追踪中心",
			  "icon": "paper-plane", 
				"children": [
					{
					  "title": "地图轨迹融合",
					  "path": "/multiline",
					  "icon": "yelp", 
					},
					{
					  "title": "人像轨迹搜索",
					  "path": "/face-match",
					  "icon": "newspaper-o",
					},
				]
			}, 
            { 
			  "title": '视频结构化中心', 
			  "path": '/structured_video',
			  "icon": 'gg-circle' 
			}
        ]
    },
    {
        "title": "预警事件中心",
        "path": "/early",
        "icon": "bell-o",
        "children": [
          {
            "title": "预警事件查询",
            "path" : "/warning-query",
            "icon": "share-alt-square",         
          },
          {
            "title": "预警事件管理",
            "path" : "/early-warning",
            "icon": "bell",         
          },
          {
            "title": "预警事件类型管理",
            "path" : "/early-warning-type",
            "icon": "bell",         
          },
        ]
    },
    {
      "title": "信息综合应用平台",
      "path": "/demo/frame",
      "icon": "globe",
          "children": [
            {
              "title": "4G指挥调度平台",
              "path" : "/demo/frame/d2-doc",
              "icon": "dot-circle-o",         
            },
            {
              "title": "天迹",
              "path" : "/demo/frame/tianji",
              "icon": "dot-circle-o",
            },
            {
              "title": "盐城市数据分析平台",
              "path" : "/demo/frame/dataanalyse",
              "icon": "dot-circle-o",
            },
            {
              "title": "壹零智慧物业综合管理系统",
              "path" : "/demo/frame/wuye",
              "icon": "dot-circle-o",
            },
            {
              "title": "公共上网管控系统",
              "path" : "/demo/frame/ggswgk",
              "icon": "dot-circle-o",
            }
          ],
    },
    {
      "title": "系统管理",
      "path": "/manage",
      "icon": "gear",
        "children": [
          {
            "title": "系统用户管理",
            "icon": "user",
			  "children":[
			     {  
					"title": '用户管理',
					"path": '/user', 
					"icon": 'user' 
				 },
                 { 
				   "title": '权限管理',
				   "path": '/userPermission',  
				   "icon": 'user' 
				 },
				 { 
				   "title": '菜单管理',
				   "path": '/userMenu',  
				   "icon": 'user' 
				 },			  
			  ]		
          },
          {
            "title": "数据库管理",
            "icon": "database",
			  "children":[
				{ 
				  "title": '人口数据库',
				  "path": '/face-list',  
				  "icon": 'address-card' 
				},
                { 
				  "title": '摄像头数据库',
				  "path": '/camera-detect',  
				  "icon": 'video-camera' 
				},
                { 
				  "title": '车辆数据库',
				  "path": '/whitelist-database',  
				  "icon": 'cubes' 
				},
                {
				  "title": '归档视频',					
				  "path": '/camera-database',  
				  "icon": 'cubes' 
				}			 
			  ] 
          },
          
          {
            "title": "日志管理",
            "icon": "file-text",
            "children": [
              {
                "title": "登录日志",
                "path" : "/sys-log-login",
                "icon": "file-word-o",
              },
              {
                "title": "操作日志",
                "path" : "/sys-log-operation",
                "icon": "file-archive-o",
              },
              {
                "title": "异常日志",
                "path" : "/sys-log-error",
                "icon": "file-o",
              },	
            ]  
          },		  
          {
            "title": "系统设置",
            "icon": "bookmark",
			  "children": [
				  { 
				    "title": '水印设置',
				    "path": '/watermark',  
					"icon": 'bookmark'
				  }
			   ]			
          }
        ]
    }
  ],
  "userPermissions": [
    "p_menu_view",
    "p_menu_edit",
    "p_menu_menu"
   ],
  "accessRoutes": [
    {
        "name": "demo-frame",
        "path": "/demo/frame",
        "component": "layoutHeaderAside",
        "componentPath": "layout/header-aside/layout",
        "meta": {
          "title": "信息综合应用平台",
          "cache": true
        },
            "children": [
                {
                  "name": "d2-doc",
                  "path": "/demo/frame/d2-doc",
                  "component": "d2-doc",
                  "componentPath": "views/modules/frame/d2-doc/index",
                  "meta": {
                    "title": "4G指挥调度平台",
                    "cache": true
                  }
                },
                {
                  "name": "tianji",
                  "path": "/demo/frame/tianji",
                  "component": "tianji",
                  "componentPath": "views/modules/frame/tianji/index",

                  "meta": {
                    "title": "天迹",
                    "cache": true
                  }
                },
                {
                  "name": "dataanalyse",
                  "path": "/demo/frame/dataanalyse",
                  "component": "dataanalyse",
                  "componentPath": "views/modules/frame/dataanalyse/index",
                  "meta": {
                    "title": "盐城市数据分析平台",
                    "cache": true
                  }
                },
                {
                  "name": "wuye",
                  "path": "/demo/frame/wuye",
                  "component": "wuye",
                  "componentPath": "views/modules/frame/wuye/index",
                  "meta": {
                    "title": "壹零智慧物业综合管理系统",
                    "cache": true
                  }
                },
                {
                  "name": "ggswgk",
                  "path": "/demo/frame/ggswgk",
                  "component": "ggswgk",
                  "componentPath": "views/modules/frame/ggswgk/index",
                  "meta": {
                    "title": "公共上网管控系统",
                    "cache": true
                  }
                },
            ],
    },
    {
        "name": "big-data",
        "path": "/big-data",
        "component": "layoutHeaderAside",
        "componentPath": "layout/header-aside/layout",
        "meta": {
          "title": "大数据分析",
          "cache": true
        },
            "children": [
                {
                  "name": "people-analyse",
                  "path": "/people-analyse",
                  "component": "people-analyse",
                  "componentPath": "views/modules/dataanalyse/people-analyse",
                  "meta": {
                    "title": "人口数据分析",
                    "cache": true
                  }
                },
                {
                  "name": "enterprise-analyse",
                  "path": "/enterprise-analyse",
                  "component": "enterprise-analyse",
                  "componentPath": "views/modules/dataanalyse/enterprise-analyse",
                  "meta": {
                    "title": "企业数据分析",
                    "cache": true
                  }
                },
                {
                  "name": "wea-analyse",
                  "path": "/wea-analyse",
                  "component": "wea-analyse",
                  "componentPath": "views/modules/dataanalyse/wea-analyse",
                  "meta": {
                    "title": "水电气数据分析",
                    "cache": true
                  }
                },
                {
                  "name": "express-analyse",
                  "path": "/express-analyse",
                  "component": "express-analyse",
                  "componentPath": "views/modules/dataanalyse/express-analyse",
                  "meta": {
                    "title": "快递数据分析",
                    "cache": true
                  }
                },
                {
                  "name": "ss-analyse",
                  "path": "/ss-analyse",
                  "component": "ss-analyse",
                  "componentPath": "views/modules/dataanalyse/ss-analyse",
                  "meta": {
                    "title": "社保数据分析",
                    "cache": true
                  }
                },
                {
                  "name": "week-analyse",
                  "path": "/week-analyse",
                  "component": "week-analyse",
                  "componentPath": "views/modules/dataanalyse/week-analyse",
                  "meta": {
                    "title": "周数据分析",
                    "cache": true
                  }
                },
              ]
    },
    {
        "name": "public-security",
        "path": "/public-security",
        "component": "layoutHeaderAside",
        "componentPath": "layout/header-aside/layout",
        "meta": {
          "title": "三维立体警务巡防中心",
          "cache": true
        },
        "children":[
			{
			  "name": "liveview",
			  "path": "/liveview",
			  "component": "liveview",
			  "componentPath": "views/modules/stream/liveview",
			  "meta": {
				"title": "实时监控显示",
				"cache": true
				},
			},
			{
			  "name": "real-video",
			  "path": "/real-video",
			  "component": "real-video",
			  "componentPath": "views/modules/stream/real-video",
			  "meta": {
				"title": "地图布控显示",
				"cache": true
				},
			},
			{
			  "name": "stream-list",
			  "path": "/stream-list",
			  "component": "stream-list",
			  "componentPath": "views/modules/stream/stream",
			  "meta": {
				"title": "历史监控查询",
				"cache": true
				},
			},
			{
			  "name": "testws",
			  "path": "/testws",
			  "component": "testws",
			  "componentPath": "views/modules/research-center/testws",
			  "meta": {
				"title": "人车情报研判中心",
				"cache": true
				},
			},
			{
			  "name": "multiline",
			  "path": "/multiline",
			  "component": "multiline",
			  "componentPath": "views/modules/face_match/multiline",
			  "meta": {
				"title": "地图轨迹融合",
				"cache": true
				},
			},
			{
			  "name": "face-match",
			  "path": "/face-match",
			  "component": "face-match",
			  "componentPath": "views/modules/face-match/face-match",
			  "meta": {
				"title": "人像轨迹搜索",
				"cache": true
				},
			},
			{
			  "name": "structured_video",
			  "path": "/structured_video",
			  "component": "structured_video",
			  "componentPath": "views/modules/face-match/structured_video",
			  "meta": {
				"title": "视频结构化中心",
				"cache": true
				},
			},
		]
    },
    {
        "name": "early-warning",
        "path": "/early-warning",
        "component": "layoutHeaderAside",
        "componentPath": "layout/header-aside/layout",
        "meta": {
          "title": "预警事件中心",
          "cache": true
         },
            "children":[
              {
                "name": "early-warning-manage",
                "path": "/early-warning",
                "component": "early-warning",
                "componentPath": "views/modules/warning/early-warning",
                "meta": {
                  "title": "预警事件管理",
                  "cache": true
                  },
              },
              {
                "name": "warning-query",
                "path": "/warning-query",
                "component": "warning-query",
                "componentPath": "views/modules/warning/warning-query",
                "meta": {
                  "title": "预警事件查询",
                  "cache": true
                  },
              },
              {
                "name": "early-warning-type",
                "path": "/early-warning-type",
                "component": "early-warning-type",
                "componentPath": "views/modules/warning/early-warning-type",
                "meta": {
                  "title": "预警事件类型管理",
                  "cache": true
                  },
              },
            ]
    },
    {	
      "name": "manage-system",
      "path": "/manage-system",
      "component": "layoutHeaderAside",
      "componentPath": "layout/header-aside/layout",
      "meta": {
        "title": "系统管理",
        "cache": true
      },
      "children":[
        {
          "name": "user",
          "path": "/user",
          "component": "user",
          "componentPath": "views/modules/sys/user",
          "meta": {
            "title": "用户管理",
            "cache": true
            },
        },
		{
          "name": "userPermission",
          "path": "/userPermission",
          "component": "userPermission",
          "componentPath": "views/modules/sys/userPermission",
          "meta": {
            "title": "权限管理",
            "cache": true
            },
        },
		{
          "name": "userMenu",
          "path": "/userMenu",
          "component": "userMenu",
          "componentPath": "views/modules/sys/userMenu",
          "meta": {
            "title": "菜单管理",
            "cache": true
            },
        },
		{
          "name": "face-list",
          "path": "/face-list",
          "component": "face-list",
          "componentPath": "views/modules/face/face",
          "meta": {
            "title": "人口数据库",
            "cache": true
            },
        },
        {
          "name": "camera-detect",
          "path": "/camera-detect",
          "component": "camera-detect",
          "componentPath": "views/modules/face/camera-detect",
          "meta": {
            "title": "摄像头数据库",
            "cache": true
            },
        },
		{
          "name": "whitelist-database",
          "path": "/whitelist-database",
          "component": "whitelist-database",
          "componentPath": "views/modules/sys/whitelist-database",
          "meta": {
            "title": "车辆数据库",
            "cache": true
            },
        },
		{
          "name": "camera-database",
          "path": "/camera-database",
          "component": "camera-database",
          "componentPath": "views/modules/sys/camera-database",
          "meta": {
            "title": "归档视频",
            "cache": true
            },
        },
        {
          "name": "log-login",
          "path": "/sys-log-login",
          "component": "log-login",
          "componentPath": "views/modules/sys/log-login",
          "meta": {
            "title": "登录日志",
            "cache": true
            },
        },
        {
          "name": "log-operation",
          "path": "/sys-log-operation",
          "component": "log-operation",
          "componentPath": "views/modules/sys/log-operation",
          "meta": {
            "title": "操作日志",
            "cache": true
            },
        },
        {
          "name": "log-error",
          "path": "/sys-log-error",
          "component": "log-error",
          "componentPath": "views/modules/sys/log-error",
          "meta": {
            "title": "异常日志",
            "cache": true
            },
        },
        {
          "name": "watermark",
          "path": "/watermark",
          "component": "watermark",
          "componentPath": "views/modules/face/watermark",
          "meta": {
            "title": "水印设置",
            "cache": true
            },
        },		
      ]
    },
  ],
  "userName": "test",
  "userRoles": [
    "R_MENUADMIN"
  ],
  "isAdmin": 0,
  "avatarUrl": "https://api.adorable.io/avatars/85/abott@adorable.png"
  }
