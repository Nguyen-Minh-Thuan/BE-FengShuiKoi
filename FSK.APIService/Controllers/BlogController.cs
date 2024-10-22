using FSK.APIService.ResponseModel;
using FSK.APIService.RequestModel;
using FSK.Repository.Models;
using FSK.Repository;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Reflection.Metadata;

namespace FSK.APIService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BlogController : ControllerBase
    {
        private readonly UnitOfWork _unitOfWork;

        public BlogController(UnitOfWork unitOfWork) => _unitOfWork = unitOfWork;

        [Authorize(Policy = "Staff")]
        [HttpPost("CreateBlog")]
        public async Task<IActionResult> CreateBlog([FromBody] CreateBlogRequestModel model)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                if (model == null)
                {
                    response.Status = false;
                    response.Message = "Invalid blog data";
                    return BadRequest(response);
                }


                var blog = new Blog
                {
                    UserId = model.UserId,
                    Title = model.Title,
                    Content = model.Content,
                    StatusId = model.StatusId,
                    ElementId = model.ElementID,
                    CreatedDate = DateTime.UtcNow,
                    ImageUrl = model.ImageUrl
                };

                await _unitOfWork.BlogRepository.CreateAsync(blog);
                await _unitOfWork.SaveChangesAsync();

                response.Status = true;
                response.Message = "Blog created successfully";
                response.Data = blog;
                return CreatedAtAction(nameof(GetBlogId), new { id = blog.BlogId }, response);
            }
            catch (Exception ex)
            {
                response.Status = false;
                response.Message = "An error occurred while creating the blog";
                return StatusCode(500, response);
            }
        }

        [HttpGet("GetAll")]
        public async Task<ActionResult<IEnumerable<Blog>>> GetAllBlogs()
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                var blog = await _unitOfWork.BlogRepository.GetAllAsync();
                
                response.Data = blog;
                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }

        }


        [HttpGet("GetBlogByElementId")]
        public async Task<ActionResult<IEnumerable<Blog>>> GetBlogByElementId(int id)
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                var blog = (await _unitOfWork.BlogRepository.GetAllAsync()).Where(x => x.ElementId == id).ToList();
                
                response.Data = blog;

                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }

        }

        [HttpGet("GetBlogById")]
        public async Task<ActionResult<IEnumerable<Blog>>> GetBlogId(int id)
        {

            BaseResponseModel response = new BaseResponseModel();

            try
            {
                response.Status = true;
                response.Message = "Success";
                var blog = await _unitOfWork.BlogRepository.GetByIdAsync(id);

                response.Data = blog;

                return Ok(response);
            }
            catch (Exception err)
            {
                response.Status = false;
                response.Message = err.Message;
                return BadRequest(response);
            }

        }

        [Authorize(Policy = "Staff")]
        [HttpPut("UpdateBlog")]
        public async Task<IActionResult> UpdateBlog([FromBody] UpdateBlogRequestModel model)
        {
            BaseResponseModel response = new BaseResponseModel();

            try
            {
                if (model == null || model.BlogId == 0 || model.UserId == 0)
                {
                    response.Status = false;
                    response.Message = "Invalid request data";
                    return BadRequest(response);
                }

                var blog = await _unitOfWork.BlogRepository.GetByIdAsync(model.BlogId);
                if (blog == null)
                {
                    response.Status = false;
                    response.Message = "Blog not found";
                    return NotFound(response);
                }

                // Update blog properties
                blog.Title = model.Title;
                blog.Content = model.Content;
                blog.StatusId = model.StatusId;
                blog.ElementId = model.ElementID;
                blog.ImageUrl = model.ImageUrl;

                // Save changes
                await _unitOfWork.BlogRepository.UpdateAsync(blog);
                await _unitOfWork.SaveChangesAsync();

                response.Status = true;
                response.Message = "Blog updated successfully";
                response.Data = blog;
                return Ok(response);
            }
            catch (Exception ex)
            {
                response.Status = false;
                response.Message = "An error occurred while updating the blog";
                return StatusCode(500, response);
            }
        }
    }
}
